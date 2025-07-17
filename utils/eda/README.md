

## Enter the toolbox

```bash
make open-toolbox
```

## Paste the topo in

```yaml
cat <<EOF > topo.json
{
  "leaf": {
    "NodeCount": 3,
    "NodeLabels": {
      "eda.nokia.com/security-profile": "managed"
    },
    "Platform": "7220 IXR-D2L",
    "LayerRole": "leaf",
    "NextLayerRole": "spine",
    "Uplinks": 2,
    "Downlinks": 2,
    "SlotCount": 1,
    "PodId": "1",
    "GenerateEdge": true,
    "NodeProfile": "srlinux-ghcr-25.3.2",
    "Version": "25.3.2",
    "OperatingSystem": "srl",
    "EdgeEncapType": "dot1q",
    "RedundancyLabelsOdd": {
      "eda.nokia.com/redundancy-group": "a"
    },
    "RedundancyLabelsEven": {
      "eda.nokia.com/redundancy-group": "b"
    },
    "CanaryLabels": {
      "eda.nokia.com/canary": "true"
    }
  },
  "spine": {
    "NodeCount": 2,
    "NodeLabels": {
      "eda.nokia.com/security-profile": "managed"
    },
    "Platform": "7220 IXR-D3L",
    "LayerRole": "spine",
    "NextLayerRole": "superspine",
    "Uplinks": 2,
    "Downlinks": 6,
    "SlotCount": 1,
    "PodId": "1",
    "NodeProfile": "srlinux-ghcr-25.3.2",
    "Version": "25.3.2",
    "OperatingSystem": "srl"
  }
}
EOF
```

## Gen the topology

```bash
edatopogen -y -f topo.json
```

## Apply new topology

```bash
kubectl -n eda apply -f generated_topo_pod_1.yaml
```

From the toolbox pod, exec:
```bash
api-server-topo -config-map-name-topo topo-config -n eda
```