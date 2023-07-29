Steps in Deploying ELK and MetricBeats on EC2 using Terraform.

1. Create AWS account (Optional) and download the access key and secret key.

2. Install terraform on your machine using by following by on the below link and the select the machine type.
    https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

3. We shall create a directory on our computer and create the following files using touch

    touch main.tf provider.tf installELK.sh variable.tf aws_security_group.tf

    main.tf - contain the resource configuration

    provider - contains the terraform version and the hashicorp provider. For this project we are using aws as the provider.

    installELK.sh - its a bash script to install java, elasticsearch, logstash, kibana, nginx and metric on our EC2 instance.

    variable.tf - contains various components that we shall reference on our configuration.

    aws_security_group.tf - contain the security policies for our EC2 instance.

4. Once all the above files are well configured, run 

    terraform init

    terraform plan

    terraform apply --auto-approve

5. After terraform is successfully completed, ssh into the running EC2 instance.

6. Modify the following the files

    sudo nano /etc/elasticsearch/elasticsearch.yml

    cluster.name: my-application
    node.name: node-1
    network.host: localhost
    http.port: 9200

    sudo nano /etc/kibana/kibana.yml

    server.port: 5601
    server.host: "0.0.0.0"
    elasticsearch.hosts: ["http://localhost:9200"]

    sudo nano /etc/nginx/sites-enabled/kibana-nginx

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

7. Restart the services to update the settings

    sudo systemctl restart elasticsearch.service
    sudo systemctl restart kibana.service
    sudo systemctl restart nginx.service

8. Copy the public IPV4 address of EC2 instance and load it on the brower, it should load Kibana page.

With this, you have successfully deployed ELK and MetricBeat using terraform.

References

https://www.terraform.io

https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html

