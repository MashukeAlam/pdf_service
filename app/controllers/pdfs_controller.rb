
class PdfsController < ApplicationController
		def index
			@file_records = FileRecord.order(created_at: :desc)
		end

			def new
				@templates = Template.all
			end

			def create
				template = Template.find(params[:template_id])
				data = JSON.parse(params[:data]) rescue {}
				pdf_filename = "pdf_#{SecureRandom.hex(8)}.pdf"
				pdf_path = Rails.root.join('public', 'generated_pdfs', pdf_filename)
				FileUtils.mkdir_p(File.dirname(pdf_path))
				file_record = FileRecord.create!(name: pdf_filename, file: "/generated_pdfs/#{pdf_filename}", status: 'processing')
				PdfGeneratorJob.perform_later(template.content, data, pdf_path.to_s, file_record.id)
				respond_to do |format|
					format.html { redirect_to pdf_path(id: file_record.id) }
					format.json { render json: { status: 'processing', id: file_record.id, url: pdf_url(file_record.id) }, status: :accepted }
				end
			end

			def show
				@file_record = FileRecord.find(params[:id])
				@pdf_path = @file_record.file if @file_record.status == 'ready' && File.exist?(Rails.root.join('public', @file_record.file))
				respond_to do |format|
					format.html
					format.json { render json: { status: @file_record.status, url: @pdf_path } }
				end
			end
end
