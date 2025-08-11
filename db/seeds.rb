# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# Example PDF templates for testing
Template.create!(
	name: "Invoice",
	signature: {
		"customer_name" => "John Doe",
		"invoice_number" => "INV-001",
		"items" => [
			{ "description" => "Widget", "quantity" => 2, "price" => 10.0 }
		],
		"total" => 20.0
	},
	content: <<~ERB
		<h2>Invoice <%= invoice_number %></h2>
		<p>Customer: <%= customer_name %></p>
		<table>
			<thead><tr><th>Description</th><th>Qty</th><th>Price</th></tr></thead>
			<tbody>
				<% items.each do |item| %>
					<tr>
						<td><%= item["description"] %></td>
						<td><%= item["quantity"] %></td>
						<td><%= item["price"] %></td>
					</tr>
				<% end %>
			</tbody>
		</table>
		<p><strong>Total:</strong> <%= total %></p>
	ERB
)

Template.create!(
	name: "Certificate",
	signature: {
		"recipient" => "Jane Smith",
		"course" => "Ruby on Rails",
		"date" => "2025-08-11"
	},
	content: <<~ERB
		<div style="text-align:center;">
			<h1>Certificate of Completion</h1>
			<p>This certifies that <strong><%= recipient %></strong></p>
			<p>has completed the course <strong><%= course %></strong></p>
			<p>on <%= date %></p>
		</div>
	ERB
)
