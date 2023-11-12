local app = import 'utils.libsonnet';
[
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: app.name,
      namespace: 'default',
    },
    spec: {
      selector: {
        app: app.name,
      },
      ports: [
        {
          port: app.port,
          targetPort: app.port,
        },
      ],
    },
  },

  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: app.name,
      namespace: 'default',
    },
    spec: {
      replicas: app.replicaCount,
      selector: {
        matchLabels: {
          app: app.name,
        },
      },
      template: {
        metadata: {
          labels: {
            app: app.name,
          },
        },
        spec: {
          containers: [
            {
              name: app.name + 'api',
              image: app.imageName,
              resources: app.resources,
              startupProbe:: {},
              livenessProbe:: {},
              readinessProbe:: {},
              ports: [
                {
                  containerPort: app.port,
                },
              ],
            },
          ],
        },
      },
    },
  },
]
