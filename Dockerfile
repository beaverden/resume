# syntax=docker/dockerfile:1
FROM debian:buster as base0
RUN apt update -y
RUN apt upgrade -y
RUN apt install chromium -y
RUN apt install npm -y
RUN npm update -g

FROM base0 as base
# Ugly workaround for M1 ARM64
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV RESUME_PUPPETEER_NO_SANDBOX=1
RUN npm install -g resume-cli --unsafe-perm=true --allow-root
RUN ln /usr/bin/chromium /usr/bin/chromium-browser

# Generate an initial resume.json
FROM base as init-base
WORKDIR /resume-init
RUN yes | resume init 

FROM scratch as init 
COPY --from=init-base /resume-init/resume.json resume.json



# Copy resume.json and build a pdf
FROM base as build-base
WORKDIR /resume 
COPY ./resume.json .
ARG THEME
RUN npm install jsonresume-theme-${THEME}
# The only way it actually works
RUN npm install -g jsonresume-theme-${THEME}
RUN resume export --theme ${THEME} resume.pdf 

FROM scratch as build-pdf
COPY --from=build-base /resume/resume.pdf resume.pdf 

# Serve as html
FROM base as serve
WORKDIR /resume 
COPY ./resume.json .
ARG THEME
ENV RESUME_THEME=${THEME}
RUN npm install jsonresume-theme-${RESUME_THEME}
# The only way it actually works
RUN npm install -g jsonresume-theme-${RESUME_THEME}
CMD resume serve --theme ${RESUME_THEME}
