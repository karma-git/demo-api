{
  name: 'fa',
  replicaCount: 2,
  image: {
    repository: 'karmawow/fastapi',
    tag: '1.0.1',
  },
  port: 8080,
  resources: {
    limits: {
      cpu: '75m',
      memory: '64Mi',
    },
    requests: {
      cpu: '50m',
      memory: '32Mi',
    },
  },
  // concatenate repo + imageTag
  imageName: self.image.repository + ':' + self.image.tag,
}
