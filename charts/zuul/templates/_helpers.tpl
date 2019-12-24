{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "zuul.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "zuul.fullname" -}}
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
{{- define "zuul.common.labels" }}
app.kubernetes.io/name: {{ include "zuul.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: zuul
{{- end }}

{{/*
Generate Zuul-executor labels
*/}}
{{- define "zuul.executor.labels" }}
{{- include "zuul.common.labels" . }}
app.kubernetes.io/component: zuul-executor
{{- end }}

{{/*
Generate Zuul-merger labels
*/}}
{{- define "zuul.merger.labels" }}
{{- include "zuul.common.labels" . }}
app.kubernetes.io/component: zuul-merger
{{- end }}

{{/*
Generate Zuul-scheduler labels
*/}}
{{- define "zuul.scheduler.labels" }}
{{- include "zuul.common.labels" . }}
app.kubernetes.io/component: zuul-scheduler
{{- end }}

{{/*
Generate Zuul-web labels
*/}}
{{- define "zuul.web.labels" }}
{{- include "zuul.common.labels" . }}
app.kubernetes.io/component: zuul-web
{{- end }}
