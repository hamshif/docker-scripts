#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "$0 is running from: $DIR"

# make this file's location working dir
cd "$(dirname "$0")"

docker exec -it --user root airflow-docker_webserver_1 chmod -R 775 ./data
docker exec -it --user root airflow-docker_webserver_1 /usr/local/airflow/data/data-common/dependency_package_py.bash

docker exec -it --user root airflow-docker_scheduler_1 chmod -R 775 ./data
docker exec -it --user root airflow-docker_scheduler_1 /usr/local/airflow/data/data-common/dependency_package_py.bash

docker exec -it --user root airflow-docker_worker_1 chmod -R 775 ./data
docker exec -it --user root airflow-docker_worker_1 /usr/local/airflow/data/data-common/dependency_package_py.bash

#docker exec -it --user root airflow-docker_flower_1 chmod -R 775 ./data
#docker exec -it --user root airflow-docker_flower_1 /usr/local/airflow/data/data-common/dependency/package_py.bash

docker-compose stop
docker-compose start