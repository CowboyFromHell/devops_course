FROM scratch
COPY ./source/test_site_app_4 /
COPY ./source/cert.pem /
COPY ./source/key.pem /
COPY ./source/libgcc_s.so.1 /usr/lib/x86_64-linux-gnu/
COPY ./tmp /tmp
ENTRYPOINT ["/test_site_app_4"]