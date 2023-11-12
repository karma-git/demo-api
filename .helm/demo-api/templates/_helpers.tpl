{{/*
Expand the name of the chart.
*/}}
{{- define "demo-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "demo-api.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "demo-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "demo-api.labels" -}}
helm.sh/chart: {{ include "demo-api.chart" . }}
{{ include "demo-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "demo-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "demo-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "demo-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "demo-api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Dynamically computes the latest image for the service according to the convention if a custom one is not specified
Example: {{- include "instance.computeImage" (dict "app" $app "instance" $instance) | nindent 10 }}
*/}}
{{- define "instance.computeImage" -}}
{{- if (hasKey .instance.image "tag") }}
image: "{{ .instance.image.repository }}:{{ .instance.image.tag }}"
{{- else }}
image: "{{ .instance.image.repository }}:{{ .app }}-latest"
{{- end }}
{{- end }}

{{/*
Dynamically computes the port number for the service according to the convention if a custom one is not specified
Example: {{- include "instance.computeContainerPort" (dict "instance" $instance) }}
*/}}
{{- define "instance.computeContainerPort" -}}
{{- if (hasKey .instance "port") }}
containerPort: {{ toString .instance.port | quote }}
{{- else }}
containerPort: {{ toString .index | quote }}
{{- end }}
{{- end }}

{{/*
Incorporate the service port number into environment variables, and merge them with user-specified environment variables
Example: {{- include "instance.computeEnvs" (dict "instance" $instance) }}
*/}}
{{- define "instance.computeEnvs" -}}
- name: PORT
  value: {{ toString .instance.port | quote }}
{{- range $k, $v := .instance.env }}
- name: {{ $k }}
  value: {{ $v }}
{{- end }}
{{- end }}

{{/*
Dynamically computes the Probes the service
Example: {{- include "instance.computeProbe" (dict "instance" $instance) | nindent 12 }}
*/}}
{{- define "instance.computeProbe" -}}
httpGet:
  path: {{ .instance.hcPath }}
  port: "{{ .app }}-http"
{{- end }}
