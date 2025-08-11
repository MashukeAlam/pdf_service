require 'ostruct'

class PdfGeneratorJob < ApplicationJob
  queue_as :default

  # Arguments:
  # template_content: ERB template string
  # data: Hash with keys/arrays matching the template signature
  # output_path: where to save the PDF
  # file_record_id: ID of the FileRecord to update
  def perform(template_content, data, output_path = nil, file_record_id = nil)
    require 'erb'
    context = OpenStruct.new(data)
    html = ERB.new(template_content).result(context.instance_eval { binding })
    
    Rails.logger.info "[PdfGeneratorJob] Rendered HTML: #{html}"
    require 'grover'
    pdf = Grover.new(html).to_pdf
    if output_path
      File.open(output_path, 'wb') { |f| f.write(pdf) }
      Rails.logger.info "[PdfGeneratorJob] PDF saved to #{output_path}"
    end
    if file_record_id
      file_record = FileRecord.find_by(id: file_record_id)
      if file_record
        file_record.update(status: 'ready', file: output_path.to_s.sub(Rails.root.join('public').to_s, ''))
        # Attach the generated PDF to the file_record
        file_record.document.attach(
          io: File.open(output_path),
          filename: File.basename(output_path),
          content_type: 'application/pdf'
        )
      end
    end
    Rails.logger.info "[PdfGeneratorJob] Node version: #{`node --version`}"
  end
end
