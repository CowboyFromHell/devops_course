FROM privetkakdela/devops_course:python_builder as builder
RUN mkdir /app
WORKDIR /app
RUN mkdir /tmp_new
COPY ./source ./
RUN pyinstaller -F app_py.py
RUN staticx ./dist/app_py app

FROM scratch
COPY --from=builder /app/app /
COPY --from=builder /app/cert.pem /
COPY --from=builder /app/key.pem /
COPY --from=builder /tmp_new /tmp
EXPOSE 443/tcp
ENTRYPOINT ["/app"]