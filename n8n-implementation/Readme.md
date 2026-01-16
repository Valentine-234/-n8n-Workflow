# Incident Automation Pipeline - n8n Workflow

## Architecture

![Architecture](n8n-implementation/docs/Screenshot 2026-01-16 120052.png)

A complete **incident intake, enrichment, persistence, and notification workflow** built using [n8n](https://n8n.io). This project demonstrates automation of DevOps/SRE workflows by processing incoming incidents and notifying the right team while storing incident data for tracking and analysis.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Setup](#setup)
- [Workflow Nodes](#workflow-nodes)
- [Demo](#demo)
- [Screenshots](#screenshots)
- [Future Enhancements](#future-enhancements)
- [License](#license)

---

## Overview

This workflow models a **real-world incident automation pipeline**:

1. Monitoring systems send incident reports via a webhook
2. Workflow validates incoming data
3. Enriches incidents with metadata (`incident_id`, `received_at`, `status`)
4. Stores incidents in a persistent data store (Google Sheets/Postgres)
5. Sends notifications to Slack or email
6. Returns a response to the originating system

> The workflow demonstrates event-driven automation, API integration, and real-time notifications using n8n.

---

## Features

- ✅ **Webhook Trigger:** Accepts incident payloads from external systems
- ✅ **Validation:** Ensures required fields (`service`, `severity`) exist
- ✅ **Data Enrichment:** Adds timestamps, unique IDs, and default statuses
- ✅ **Persistence:** Stores incident data in Google Sheets / Postgres
- ✅ **Notifications:** Sends formatted alerts to Slack or email
- ✅ **API Response:** Confirms receipt of the incident with an incident ID

---

**Components:**

1. **Webhook Node** – Receives POST requests from monitoring systems  
2. **IF Node** – Validates required fields  
3. **Set Node** – Adds metadata and generates unique incident ID  
4. **Google Sheets / Postgres Node** – Saves incident for tracking  
5. **Slack / Email Node** – Sends alert to relevant team  
6. **Respond to Webhook Node** – Returns acknowledgment

---

## Setup

### Prerequisites

- [n8n](https://n8n.io) Cloud or self-hosted
- Google account (for Google Sheets) or Postgres database
- Slack workspace or Email SMTP credentials

### Steps

1. **Clone Workflow**
   - Download JSON from this repository
   - Import into n8n via `Import from File`

2. **Configure Nodes**
   - Webhook: Set path `/incident`  
   - Google Sheets / Postgres: Connect with credentials  
   - Slack / Email: Connect with API key or SMTP  

3. **Test Workflow**
   - Use Postman or curl to POST sample incident:

```bash
curl -X POST https://<your-n8n-instance>/webhook/incident \
-H "Content-Type: application/json" \
-d '{
    "service": "payments",
    "severity": "high",
    "message": "API latency above threshold"
}'

## Workflow Steps
```
| Node                     | Purpose                                                                 |
| ------------------------ | ----------------------------------------------------------------------- |
| **Webhook**              | Entry point that receives incoming incident events from monitoring tools |
| **IF**                   | Validates the incoming payload to ensure all required fields are present |
| **Set**                  | Enriches the incident data with additional fields such as `incident_id`, `received_at`, and `status` |
| **Google Sheets / Postgres** | Persists the processed incident data for tracking, auditing, and analysis |
| **Slack / Email**        | Sends real-time notifications to the relevant team or stakeholders |
| **Respond to Webhook**   | Confirms successful receipt and processing back to the monitoring system |

## Outcome
By the end of this workflow, incidents are reliably validated, stored, and communicated to the team, ensuring visibility, traceability, and timely response while maintaining proper integration with external systems.

## Demo

### 1. Incoming Incident
Example payload received by the webhook:

```json
{
  "service": "payments",
  "severity": "high",
  "message": "API latency above threshold"
}

## Screenshots
![Screenshots](n8n-implementation/docs/Screenshots/Screenshot 2026-01-16 114813.png)
![Screenshots](n8n-implementation/docs/Screenshots/Screenshot 2026-01-16 122047.png)

## Future Enhancements

Severity-based routing (e.g., high → Ops, low → Dev)

Auto-close resolved incidents after X time

Deduplication for repeated alerts within short time windows

Integrate Postgres / Notion dashboards for reporting
