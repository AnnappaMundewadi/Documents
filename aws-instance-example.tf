resource "aws_instance" "web1" {
   ami           = "ami-04ad2567c9e3d7893"
   instance_type = "t2.micro"
   count = 1
  vpc_security_group_ids = ["sg-050c66b16eccd3620"]
   key_name               = "Linux_Terraform-Chef" 
   iam_instance_profile =   "myManagedInstanceRole"
   user_data = <<-EOF
      #!/bin/bash     
      sudo amazon-linux-extras install ansible2 -y
      sudo yum install git -y
      sudo yum install maven -y      
      git -C ./home/ec2-user clone https://github.com/GarvitKushwaha/Terra-Ansi-jFrog.git          
      cd /home/ec2-user/Terra-Ansi-jFrog && ansible-playbook main.yml -f 10
      cd /home/ec2-user/Terra-Ansi-jFrog && wget -O Java-Ansible.war https://abishek.jfrog.io/artifactory/abi_new/MyMavanWebapp/Java-Ansible/0.0.1-SNAPSHOT/Java-Ansible-0.0.1-SNAPSHOT.war
      cd /home/ec2-user/Terra-Ansi-jFrog && ansible-playbook deploy.yml -f 10
      EOF
   }