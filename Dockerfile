FROM python:3.9

RUN pip install mkdocs mkdocs-material

WORKDIR /mkdocs

EXPOSE 8000

CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8000"]