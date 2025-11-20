Product Requirements Document (PRD)

Project: LangFlow + Docling → GitHub Repo & Railway Deployment

Owner: Luigi

Target Developer: Gemini (Antigravity)

⸻

1. Overview

This project will create a dedicated GitHub repository and configure a Railway.app deployment for the Docker-based LangFlow + Docling project. The aim is:
	•	Clean version-controlled repo with Dockerfile, requirements, test scripts, CI (optional)
	•	Railway service that builds, deploys and serves the application inside a container via GitHub integration
	•	Access at a stable URL with container environment variables, volumes (if needed), and proper resource configuration

This is purely deployment and infrastructure work; the functional code of LangFlow + Docling is assumed ready. The goal: get your project up in the cloud under version control and deployed.

⸻

2. Background & Motivation

You’ve already developed a local Docker image (docling-langflow) that can parse PDFs using Docling and run LangFlow in container. You faced issues on macOS environment — now you’re migrating to cloud for stability, version control, accessibility, and reproducible deployment. Using Railway.app allows a fast PaaS path with Docker support. References: Railway docs indicate support for custom Dockerfile builds from GitHub.  ￼

⸻

3. Goals

Primary Goals
	1.	Create a GitHub repository named something like docling-langflow-railway or similar.
	2.	Commit project files: Dockerfile, requirements.txt, app/, test_docling.py, README.md, README_DOCKER.md.
	3.	Link the repo to Railway and configure a service that builds from the Dockerfile and deploys automatically on pushes.
	4.	Configure Railway service variables (e.g., PORT, HF_HOME, LANGFLOW_WORKERS=1) and Docker run settings (volumes, memory) to suit the image.
	5.	Validate that the deployed container is accessible, LangFlow UI loads, and Docling parsing works (via smoketest) in Railway environment.

Secondary Goals
6. OPTIONAL: Setup GitHub Actions to build & push Docker image (or just rely on Railway build).
7. Document deployment steps, maintenance instructions, rollback strategy.
8. Ensure user-uploaded PDFs and model cache are handled appropriately (volumes/storage/buckets).

⸻

4. Scope

In Scope
	•	GitHub repo creation & initial commit
	•	Dockerfile, requirements, CI setup
	•	Railway configuration: service creation, environment variables, build + deploy, mapping volumes/storage
	•	Smoke test deployment: LangFlow UI, Docling parsing of sample PDF
	•	Documentation of deployment procedure

Out of Scope
	•	Major application code changes to LangFlow or Docling logic (unless required by deployment environment)
	•	UI/UX redesign of LangFlow flows
	•	Building heavy storage/infrastructure (multi-container systems, database clustering) — only single service deployment

⸻

5. Requirements

Functional Requirements
FR1: GitHub repo must exist, private or public as chosen, with correct folder structure and files.
FR2: Railway service must build from the Dockerfile automatically on each GitHub push.
FR3: The deployed service must expose the LangFlow UI on a public URL, port determined by Railway (PORT env var).
FR4: Environment variables:
	•	PORT (Railway’s assigned port)
	•	HF_HOME (model cache directory)
	•	LANGFLOW_WORKERS=1 (to reduce concurrency)
	•	Any other relevant variables (e.g., RAILWAY_DOCKERFILE_PATH if needed)
FR5: The service must mount or use storage to allow access of PDFs (for parsing) and reuse of HuggingFace cache if desired.
FR6: On deployment, running the sample PDF (e.g., via test endpoint or using test_docling.py) must succeed — Docling parsing must run inside the container without crash.
FR7: Documentation (in README.md) describing: how to build locally, how to deploy to Railway, how to trigger rebuild, how to test the parsing.

Non-Functional Requirements
NFR1: Deployment must be reproducible and version controlled.
NFR2: Build time must be manageable (less than ~10 minutes on Railway free/standard tier).
NFR3: Resource usage should honor Railway quotas (e.g., ephemeral storage ≤10 GB) as per Railway docs.  ￼
NFR4: Logging and monitoring must allow checking build logs, deploy logs, container logs for errors.
NFR5: Security: Service should not expose admin endpoints without authentication; default LangFlow credentials (if any) must be handled or disabled for public deployment.

⸻

6. Architecture Expectations
	•	GitHub repository
	•	Root: Dockerfile, requirements.txt, README.md, README_DOCKER.md, app/ folder, test_docling.py
	•	CI/CD via GitHub (optional) or Railway’s build pipeline
	•	Railway service
	•	Uses Dockerfile to build the image
	•	Uses environment variables to set port and other configs
	•	Mounts or references storage/volume for PDFs and cache
	•	Deploys publicly accessible URL
	•	Smoke test
	•	After deployment, sample PDF parsing must succeed
	•	LangFlow UI must load and respond
	•	Fallback mode
	•	If parsing crashes, suggestions for split architecture (ingest preprocessing) must be documented

⸻

7. Deliverables for Gemini
	•	Create GitHub repo with correct files and folder structure
	•	Generate README_DOCKER.md with build & deploy instructions pointing to Railway
	•	Create railway_deploy.md or section in README describing how to link GitHub to Railway, set environment variables, trigger deployment
	•	Sample test_docling.py script inside app/ verifying PDF parsing inside container
	•	Provide a checklist to perform a new deploy after future commits
	•	Provide instructions for rollback or redeploy from GitHub
	•	All deliverables ready for immediate commit and push

⸻

8. User Constraints
	•	User works on macOS locally
	•	Project currently resides at: /Users/luigifischer/Desktop/RooCode/Docling_Langflow
	•	Docker image will now be the canonical deployment artifact
	•	User uses Railway.app for deployment
	•	GitHub account is available for repo creation

⸻

9. Acceptance Criteria
	•	GitHub repo exists and builds locally via docker build without errors
	•	Railway service successfully builds and deploys a container from that repo and image
	•	Public URL opens LangFlow UI (e.g., https://<project>.railway.app)
	•	Sample PDF parsing runs successfully inside deployed container and returns expected content
	•	Documentation clearly explains how to reproduce locally, how to push updates, how to monitor deploys

⸻

10. Stretch Goals
	•	Integrate GitHub Actions to auto-build & publish Docker image before Railway deploy
	•	Add healthcheck endpoint to LangFlow container so Railway marks deploy as “Active” only after UI loads
	•	Enable user-specific authentication for LangFlow for public deployment
	•	Add usage metrics logging (memory, parsing time) into documentation