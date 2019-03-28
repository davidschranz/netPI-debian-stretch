FROM arm32v7/python:3.7.2-alpine3.9
RUN [ "cross-build-start" ]

RUN apk add --virtual mypacks g++ lapack-dev 
RUN pip install --no-cache-dir scipy
RUN apk del mypacks

RUN [ "cross-build-end" ]
