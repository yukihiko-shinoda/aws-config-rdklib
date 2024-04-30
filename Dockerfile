FROM python:3.12.3-slim-bookworm
# FROM python:3.7.17-slim-bookworm
# When poetry install --no-interaction:
# error: command 'gcc' failed: No such file or directory
RUN apt-get update && apt-get install -y build-essential manpages-dev
# setuptools 65.3.0 can't lock package defined its dependencies by pyproject.toml
RUN pip install --no-cache-dir --upgrade pip==24.0 setuptools==69.2.0
# RUN pip install --no-cache-dir --upgrade pip setuptools
# see: https://pythonspeed.com/articles/activate-virtualenv-dockerfile/
ENV PIPENV_VENV_IN_PROJECT=1
WORKDIR /workspace
COPY . /workspace
RUN pip --no-cache-dir install poetry==1.6.1 \
 && poetry install --no-interaction
# RUN pip --no-cache-dir install poetry \
#  && poetry install --no-interaction
ENTRYPOINT [ "poetry", "run" ]
CMD ["pytest"]