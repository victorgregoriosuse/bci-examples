# https://registry.suse.com/
FROM registry.suse.com/bci/bci-base:latest

ENV ZYPPERCMD="zypper --non-interactive"

# https://jupyter.org/install
RUN $ZYPPERCMD install python3 python3-pip
RUN pip3 install --upgrade pip
RUN pip3 install jupyterlab notebook 

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
EXPOSE 8888/tcp 

# https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["jupyter", "notebook", "--no-browser", "--port=8888"]
