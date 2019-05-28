## Instructions for using Airflow docker

Step 1
- Go to data project and pull the branch you need

Step 2
- Run command-> git submodule update --init --recursive 

Step 3
- In module docker-scripts -> airflow-docker -> credentials 
	- Copy to this directory gcp-service-account-credentials.json file 
	If your source git repo is in gcp
	- Create in this directory google-source-credentials.sh file
		- Navigate to https://source.cloud.google.com/rtp-gcp-poc/data
		- Click on "Clone" button 
		- Check "Manually generated credentials"
		- Click "Generate and store your Git credentials." And past content in google-source-credentials.sh 

Step 4
- Run ./image_build.sh

Step 5
- After run has completed run -> docker-compose up -d

Step 6
- When docker is up run docker-scripts/airflow-docker/custum_lib_instalation.sh 



## Setup remote debug in IntelliJ

Step 1
- Go to Tools->Deployment->Configuration
  - Click on "+" in order to add a new deployment configuration:
    - Type deployment configuration name
    - Choose SFTP as type
  
  - Click on "Connection tab", fill the following:
    - SFTP host: 0.0.0.0
    - Port: 21000
    - Root path: /usr/local/airflow/
    - User name: airflow
    - Password: airflow
    - Check "Save password"
    - Click on "Test SFTP connection" - Should works!  
    
  - Click on Mappings, fill the following:
    - Local path: Type here your base local path
    - Deployment path on server: /
    - Web path on server: /
    

- Go to File->Project Structure->SDKs   
  - Click on "+", choose Python SDK
  - Click on SSH Interpreter
  - Choose "Existing server configuration"
  - Choose the deployment configuration name as you configured before
  
- Go to Run->Edit Configurations
  - Click on "+" -> add python
  - Choose the python script you wish to debug
  - In Python interpreter, choose "Use specified interpreter"
  - Choose the Remote python interpreter 
  
  
  
  open ssh port
  
  docker exec -it airflow-docker_webserver_1 bash