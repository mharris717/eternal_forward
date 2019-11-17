# EternalForward

Manage a `kubectl port-forward`, and renew it if the connection dies. The `kubectl` command is spawned in the background the first time you try and access something.

Currently this only works to view served web pages from the pod.

Run `eternal_forward APP` to start it, where APP is the `app` label of your kube deployment. It will pick a running pod to forward to.

The pod will be available by default at port 5555. Run `eternal_forward help` to see options.

Example:

```
✔ ~/code/liveramp/wherever
$ eternal_forward segment-lookalike
== Sinatra (v2.0.7) has taken the stage on 5555 for development with backup from Puma
```
