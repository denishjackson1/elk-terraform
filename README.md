# Steps in Deploying ELK and MetricBeats on EC2 using Terraform.

1. Create an AWS account (Optional if you already have created one) and download the access key and secret key.

2. Install Terraform on your machine using the below link and then select the machine type.
    ```bash
   https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
    ```

4. We shall create a directory on our computer and create the following files using touch
    ```bash
    touch main.tf provider.tf installELK.sh variable.tf aws_security_group.tf
    ```
    `main.tf` - contains the resource configuration
    
    `provider` - contains the Terraform version and the Hashicorp provider. For this project, we are using AWS as the provider.
    
    `installELK.sh` - it's a bash script to install java, elasticsearch, logstash, kibana, nginx and metric on our EC2 instance.
    
    `variable.tf` - contains various components that we shall reference in our configuration.
    
    `aws_security_group.tf` - contains the security policies for our EC2 instance.

5. Once all the above files are well configured, run 
    ```bash
     terraform init
     terraform plan   
     terraform apply --auto-approve
    ```
6. After terraform apply is completed, ssh into the running EC2 instance.

7. Modify the following files
    ```bash
    sudo nano /etc/elasticsearch/elasticsearch.yml
    ```
           
        cluster.name: my-application
        node.name: node-1
        network.host: localhost
        http.port: 9200
           
    
    
    ```bash
    sudo nano /etc/kibana/kibana.yml
    ```

   
        server.port: 5601
        server.host: "0.0.0.0"
        elasticsearch.hosts: ["http://localhost:9200"]
       
    ```bash
    sudo nano /etc/nginx/sites-enabled/kibana-nginx
    ```
       
        server {
        listen 80;
         
        server_name hostaname;
         
        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/.kibana-user;
         
        location / {
            proxy_pass http://localhost:5601;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
            }
        }
8. Restart the services to update the settings
    ```bash
    sudo systemctl restart elasticsearch.service
    sudo systemctl restart kibana.service
    sudo systemctl restart nginx.service
    ```
10. Copy the public IPV4 address of EC2 instance and load it on the browser, it should load Kibana page.

   With this, you have successfully deployed ELK and MetricBeat using Terraform.
