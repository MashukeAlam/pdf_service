# PDF Service

## Project Overview
This project is a PDF generation and management service. It provides endpoints and background jobs for creating, storing, and serving PDF files, with support for templates and file records.

## Architecture Overview
- **Framework:** Ruby on Rails
- **Main Components:**
  - Controllers: Handle HTTP requests (PDFs, templates, home)
  - Models: Represent templates and file records
  - Jobs: Background PDF generation
  - Views: HTML/ERB templates for rendering
  - Assets: Images, stylesheets, and JavaScript
- **Storage:** PDFs and related files are stored in the `public/generated_pdfs` and `storage` directories.

## Setup Instructions
1. **Clone the repository:**
   ```sh
   git clone <repo-url>
   cd pdf_service
   ```
2. **Install dependencies:**
   ```sh
   bundle install
   yarn install # if using JS assets
   ```
3. **Set up the database:**
   ```sh
   rails db:setup
   ```
4. **Run the server:**
   ```sh
   rails server
   ```
5. **(Optional) Run background jobs:**
   ```sh
   # Example for Sidekiq
   bundle exec sidekiq
   ```

## API Details
- **PDFs**
  - `GET /pdfs`: List PDFs
  - `POST /pdfs`: Create a new PDF
  - `GET /pdfs/:id`: Download a PDF
- **Templates**
  - `GET /templates`: List templates
  - `POST /templates`: Create a new template
  - `GET /templates/:id`: Show template details

## Usage Examples
- **Generate a PDF:**
  ```sh
  curl -X POST http://localhost:3000/pdfs -d '{"template_id":1,"data":{...}}' -H 'Content-Type: application/json'
  ```
- **Download a PDF:**
  ```sh
  curl -O http://localhost:3000/pdfs/1
  ```

## Contributing
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License
Specify your license here.
