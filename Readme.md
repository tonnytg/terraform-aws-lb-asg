# AWS Load Balancer and Auto Scaling

## How to use:
```
git clone REPO
```

Remember edit Variables
Atetion on AMI because this instance need listening on port 80
> :warning: **If your AMI don`t have webservice running port 80**: Be very careful here!
```
$vim variables.tf
```

Maybe do you want create to diferents envirements
```
$vim dev.tfvars
```

Start terraform and download modules
```
$terraform init
```
Review this code
```
$terraform plan
```

Take a coffee and Enjoy!
```
$terrafom apply -auto-approve
```

After terraformation you will recive a DNS to access LoadBalancer
But if you lost this output, this code create a file with name **url-loadbalancer.txt**