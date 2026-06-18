# Network observations

## Benign infrastructure used in the chain

- `github.com`
- `release-assets.githubusercontent.com`

These domains were used to retrieve `legendary.exe`. The GitHub-hosted download does not make the sample benign, but it does document where the payload came from.

## Suspicious or noteworthy infrastructure

- `anondrop.net`
- `doxbin.com`
- `doxbin.net`
- `ethereum.publicnode.com`
- `servus.doxbin.cy`

## Notable endpoints

| Endpoint | Behavior |
| --- | --- |
| `https://github.com/derrod/legendary/releases/download/0.20.34/legendary.exe` | Initial download attempt |
| `https://github.com/legendary-gl/legendary/releases/download/0.20.34/legendary.exe` | Redirect target |
| `https://release-assets.githubusercontent.com/...` | Final signed asset URL for `legendary.exe` |
| `https://anondrop.net/85433?action=init` | `POST`, returned `405` |
| `https://doxbin.com/18783?action=init` | `POST`, returned `403` |
| `https://ethereum.publicnode.com/` | `POST`, returned `200` |

## Readout

The network picture mixes legitimate hosting with domains that are much harder to justify in a benign workflow. For reporting, that split is useful: it shows both the delivery path and the surrounding infrastructure the sample cared to contact.
