# demoIstio
Demo to get RPS and latency from Istio for applications

<div>
<img width="750" alt="grafana" src="https://user-images.githubusercontent.com/27221807/40750040-f3956832-6433-11e8-9d00-0857f69a8037.png">
</div>

## Prerequisites
* Kubernetes 1.7.3 +
* Istio 0.3 + (with Prometheus addon)
* Turbonomic appliance


## Deploy the demo in 4 steps

#### Step1 Deploy necessary Istio metrics
The Istio metrics are to generate request count and latency for pods and services.
The [script](https://github.com/turbonomic/prometurbo/tree/master/appmetric/scripts/istio) to creat them in project [Prometurbo/appmetric](https://github.com/turbonomic/prometurbo).

The scipt is also copied to this project, so the metrics can be created via:
```bash
cd istio
istioctl create -f ip.turbo.metric.yaml
```

#### Step2 Deploy Kubeturbo and Prometurbo
[Kubeturbo](https://github.com/turbonomic/kubeturbo) and [Prometurbo](https://github.com/turbonomic/prometurbo) are two Turbonomic probes, which can probe Kubernetes Pods and services, along with their latency and QPS.

```bash
cd kubeturbo
## change the address and login password for the Turbonomic appliance.
kubectl create -f kubeturbo-all-in-one.yaml
kubectl create -f prometurbo.yaml
```


#### Step 3 Deploy Music application and its client
The music application is a simulated by [a cpu-intensive web serivce](https://github.com/songbinliu/webApp).
The [client](https://github.com/songbinliu/webclient) is a multi-threaded golang http client: each request to a specific url will trigger the server to do a certain amount calculation.

To deploy the application and the client:
```bash
cd music
sh gen.sh 
kubectl create -f injected.music.yaml
kubectl create -f client.music.yaml
```

#### Step 4 Deploy Image application and its client
The [image application](https://github.com/songbinliu/inceptionServer) is Tensorflow-based image category service.
The [client](https://github.com/songbinliu/webclient) is a multi-threaded golang http client: each request to a specific url will trigger an image prediction action.

To deploy the application and the client:
```bash
cd image
sh gen.sh 
kubectl create -f injected.image.yaml
kubectl create -f client.image.yaml
```

#### Step 5 (Optional) Visualization in Grafana
To visualize service response time and request-per-second, the [Grafana](https://github.com/grafana/grafana/) addon should be installed for Istio.

Login to Grafana UI, and import the dashboard from `demoIstio/istio/svcMonitor.grafana.json`



