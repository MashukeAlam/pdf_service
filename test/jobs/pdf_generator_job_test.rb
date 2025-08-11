require "test_helper"

class PdfGeneratorJobTest < ActiveJob::TestCase
  test "generates PDF from ERB and data" do
    template = '<h1>Hello <%= name %></h1>'
    data = { 'name' => 'Test User' }
    output_path = Rails.root.join('tmp', "test_pdf_#{SecureRandom.hex(4)}.pdf")
    PdfGeneratorJob.perform_now(template, data, output_path.to_s)
    assert File.exist?(output_path), 'PDF file should be created'
    # File.delete(output_path) if File.exist?(output_path)
  end
  
   test "generates PDF with arrays and nested data" do
     template = <<~ERB
       <!DOCTYPE html>
       <html>
       <head>
         <meta charset="UTF-8">
         <style>
           body { font-family: 'Segoe UI', Arial, sans-serif; margin: 40px; }
           h2 { color: #2a4365; }
           table { width: 100%; border-collapse: collapse; margin-top: 16px; }
           th, td { border: 1px solid #e2e8f0; padding: 8px 12px; }
           th { background: #f1f5f9; }
           .total { font-weight: bold; }
         </style>
       </head>
       <body>
         <h2>Order for <%= customer["name"] %></h2>
         <table>
           <thead>
             <tr>
               <th>Item</th>
               <th>Qty</th>
               <th>Price</th>
             </tr>
           </thead>
           <tbody>
             <% items.each do |item| %>
               <tr>
                 <td><%= item["name"] %></td>
                 <td><%= item["quantity"] %></td>
                 <td>$<%= item["price"] %></td>
               </tr>
             <% end %>
           </tbody>
         </table>
         <p class="total">Total: $<%= total %></p>
       </body>
       </html>
     ERB
     data = {
       'customer' => { 'name' => 'Alice Example' },
       'items' => [
         { 'name' => 'Book', 'quantity' => 2, 'price' => 12.5 },
         { 'name' => 'Pen', 'quantity' => 5, 'price' => 1.2 }
       ],
       'total' => 2 * 12.5 + 5 * 1.2
     }
     output_path = Rails.root.join('tmp', "test_pdf_complex_#{SecureRandom.hex(4)}.pdf")
     PdfGeneratorJob.perform_now(template, data, output_path.to_s)
     assert File.exist?(output_path), 'Complex PDF file should be created'
     # File.delete(output_path) if File.exist?(output_path)
   end
end
