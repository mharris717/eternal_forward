# EternalForward

Manage a `kubectl port-forward`, and renew it if the connection dies. The `kubectl` command is spawned in the background the first time you try and access something.

This is nice for situations where you want to keep a `port-forward` up for a long time and not deal with restarting it. For example, if you update the kube deployment (which deletes the pod you're currently forwarding to), things will transparently continue to work. EternalForward will detect that the old connection is gone, and spawn one to a new pod.

Currently this only works to view served web pages from the pod. The first time someone is interested in using this but can't due to this limitation, I'll happily enhance it to be a proper proxy. It was just too enticing to use `open-uri` and pass a string around to get a POC up.

Run `eternal_forward APP` to start it, where APP is the `app` label of your kube deployment. It will pick a running pod to forward to.

The pod will be available by default at port 5555. Run `eternal_forward help` to see options.

Example:

```
✔ ~/code/liveramp/wherever
$ eternal_forward segment-lookalike
== Sinatra (v2.0.7) has taken the stage on 5555 for development with backup from Puma
```
