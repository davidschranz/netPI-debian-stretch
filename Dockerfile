FROM arm32v7/python:3.7.2-alpine3.9

RUN [ "cross-build-start" ]
RUN [ "cross-build-end" ]

