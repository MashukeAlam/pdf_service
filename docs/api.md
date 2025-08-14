# API Reference

## PDFs
### Create PDF
- **Endpoint:** `POST /pdfs`
- **Description:** Generate a new PDF from a template and data.
- **Request Body:**
  - `template_id` (integer): ID of the template
  - `data` (object): Data to fill the template
- **Response:**
  - `id` (integer): PDF ID
  - `url` (string): Download URL

### List PDFs
- **Endpoint:** `GET /pdfs`
- **Description:** List all generated PDFs.

### Download PDF
- **Endpoint:** `GET /pdfs/:id`
- **Description:** Download a specific PDF by ID.

## Templates
### Create Template
- **Endpoint:** `POST /templates`
- **Description:** Create a new template for PDF generation.
- **Request Body:**
  - `name` (string): Template name
  - `content` (string): Template content (HTML/ERB)

### List Templates
- **Endpoint:** `GET /templates`
- **Description:** List all templates.

### Show Template
- **Endpoint:** `GET /templates/:id`
- **Description:** Get details of a specific template.
