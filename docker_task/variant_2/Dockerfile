FROM python:latest as builder
RUN mkdir /app
WORKDIR /app
RUN mkdir /tmp_new
COPY ./source ./
RUN apt update && apt install patchelf upx-ucl -y
RUN pip3 install -r requirements.txt
RUN pyinstaller -F app_py.py
RUN staticx ./dist/app_py app
RUN ls -lh

FROM scratch
COPY --from=builder /app/app /
COPY --from=builder /tmp_new /tmp
EXPOSE 8080/tcp
ENTRYPOINT ["/app"]