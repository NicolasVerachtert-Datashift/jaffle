FROM python:3.11-slim-bullseye

WORKDIR /usr/app

COPY ./models/ /usr/app/models/
COPY ./macros/ /usr/app/macros/
COPY ./seeds/ /usr/app/seeds/
COPY profiles.yml /usr/app/profiles.yml
COPY packages.yml /usr/app/packages.yml
COPY dbt_project.yml /usr/app/dbt_project.yml

# RUN python3 -m venv .venv/dbt
# RUN source .venv/dbt/bin/activate
RUN apt update
RUN apt install -y git
RUN pip install dbt-core dbt-postgres
RUN dbt deps

CMD /bin/bash -c "dbt seed --full-refresh --vars '{\"load_source_data\": true}' && dbt run"
