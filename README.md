# EternalForward

Manage a `kubectl port-forward`, and renew it if the connection dies. Currently this only works to view served web pages from the pod.

Run `eternal_forward APP` to start it, where APP is the `app` label of your kube deployment. It will pick a running pod to forward to.

The pod will be available by default at port 5555. Run `eternal_forward help` to see options.
