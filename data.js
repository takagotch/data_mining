var dataset = [
  <% @data.each do |d| %>
	{date:<%= d.date %>, value:<%= d.value %>},
  <% end %>
];

