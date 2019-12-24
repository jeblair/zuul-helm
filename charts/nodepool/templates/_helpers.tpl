{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "nodepool.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nodepool.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Generate basic labels
*/}}
{{- define "nodepool.common.labels" }}
app.kubernetes.io/name: {{ include "nodepool.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: nodepool
{{- end }}

{{/*
Generate Nodepool-builder labels
*/}}
{{- define "nodepool.builder.labels" }}
{{- include "nodepool.common.labels" . }}
app.kubernetes.io/component: nodepool-builder
{{- end }}

{{/*
Generate Nodepool-launcher labels
*/}}
{{- define "nodepool.launcher.labels" }}
{{- include "nodepool.common.labels" . }}
app.kubernetes.io/component: nodepool-launcher
{{- end }}

