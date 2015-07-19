The executable launches tar with ownership from the vortex3 username.

The trisk is that $$ is interpreted as the pid by bash when trying to ls the resulting archive file.

But in the c execution $$ is passed as a string and thus not reinterpreted by bash.

To force bash to not interprete the $$ during the ls, do something like this :

```
cd /
vortex/vortex3 etc/vortex_pass/vortex3
ls '/tmp/ownership.$$.tar'
tar -xf '/tmp/ownership.$$.tar' /tmp/xxxx/
```

level3 pass :

64ncXTvx#
