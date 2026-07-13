# MosDNS ad list

MosDNS-compatible domain blocklist mirrored from
[217heidai/adblockfilters](https://github.com/217heidai/adblockfilters).
The upstream list is merged, deduplicated, validated and updated every eight
hours. This repository mirrors the upstream MosDNS format without changing its
domain entries.

Subscription URL:

```text
https://raw.githubusercontent.com/yaakauna/adlist/main/adblockmosdns.txt
```

The GitHub Actions workflow refreshes the list every eight hours. The router
helper in `router/update-adlist.sh` downloads the published list, validates it,
replaces the local file atomically, and restarts MosDNS only when the list has
changed.

`router/config_custom.yaml` is the deployed MosDNS v5 configuration example.
It checks the blocklist before cache lookup and returns NXDOMAIN for blocked
domains. Put local false-positive exceptions in
`/etc/mosdns/rule/adblock-allowlist.txt`.

Source data is distributed under the upstream project's GPL-3.0 license. See
`LICENSE` and the upstream project for attribution and source details.
