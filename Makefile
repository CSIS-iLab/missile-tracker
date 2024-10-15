run_app:
	python3 app.py & sleep 30

	wget -r http://127.0.0.1:8050/
	wget -r http://127.0.0.1:8050/missile-tracker/_dash-layout 
	wget -r http://127.0.0.1:8050/missile-tracker/_dash-dependencies

	wget -r http://127.0.0.1:8050/missile-tracker/_dash-component-suites/dash/dcc/async-graph.js
	wget -r http://127.0.0.1:8050/missile-tracker/_dash-component-suites/dash/dcc/async-highlight.js
	wget -r http://127.0.0.1:8050/missile-tracker/_dash-component-suites/dash/dcc/async-markdown.js
	wget -r http://127.0.0.1:8050/missile-tracker/_dash-component-suites/dash/dcc/async-datepicker.js

	wget -r http://127.0.0.1:8050/missile-tracker/_dash-component-suites/dash/dash_table/async-table.js
	wget -r http://127.0.0.1:8050/missile-tracker/_dash-component-suites/dash/dash_table/async-highlight.js

	wget -r http://127.0.0.1:8050/missile-tracker/_dash-component-suites/plotly/package_data/plotly.min.js

	mv 127.0.0.1:8050 pages_files
	ls -a pages_files
	ls -a pages_files/missile-tracker/assets

	find pages_files -exec sed -i.bak 's|missile-tracker/_dash-component-suites|missile-tracker\\/missile-tracker/_dash-component-suites|g' {} \;
	find pages_files -exec sed -i.bak 's|missile-tracker/_dash-layout|missile-tracker/missile-tracker/_dash-layout.json|g' {} \;
	find pages_files -exec sed -i.bak run_app:
	python3 app.py & sleep 30

	wget -r http://127.0.0.1:8050/
	wget -r http://127.0.0.1:8050/_dash-layout 
	wget -r http://127.0.0.1:8050/_dash-dependencies

	wget -r http://127.0.0.1:8050/_dash-component-suites/dash/dcc/async-graph.js
	wget -r http://127.0.0.1:8050/_dash-component-suites/dash/dcc/async-highlight.js
	wget -r http://127.0.0.1:8050/_dash-component-suites/dash/dcc/async-markdown.js
	wget -r http://127.0.0.1:8050/_dash-component-suites/dash/dcc/async-datepicker.js
	wget -r http://127.0.0.1:8050/_dash-component-suites/dash/dcc/async-dropdown.js

	wget -r http://127.0.0.1:8050/_dash-component-suites/dash/dash_table/async-table.js
	wget -r http://127.0.0.1:8050/_dash-component-suites/dash/dash_table/async-highlight.js

	wget -r http://127.0.0.1:8050/_dash-component-suites/plotly/package_data/plotly.min.js

	mv 127.0.0.1:8050 pages_files

	find pages_files -exec sed -i.bak 's|_dash-component-suites|dash-actions-tutorial\\/_dash-component-suites|g' {} \;
	find pages_files -exec sed -i.bak 's|_dash-layout|dash-actions-tutorial/_dash-layout.json|g' {} \;
	find pages_files -exec sed -i.bak 's|_dash-dependencies|dash-actions-tutorial/_dash-dependencies.json|g' {} \;
	find pages_files -exec sed -i.bak 's|_reload-hash|dash-actions-tutorial/_reload-hash|g' {} \;
	find pages_files -exec sed -i.bak 's|_dash-update-component|dash-actions-tutorial/_dash-update-component|g' {} \;
	find pages_files -exec sed -i.bak 's|assets|dash-actions-tutorial/assets|g' {} \;

	mv pages_files/_dash-layout pages_files/_dash-layout.json
	mv pages_files/_dash-dependencies pages_files/_dash-dependencies.json

	ps | grep python | awk '{print $$1}' | xargs kill -9	

clean_dirs:
	ls
	rm -rf 127.0.0.1:8050/
	rm -rf pages_files/
	rm -rf joblib's|missile-tracker/_dash-dependencies|missile-tracker/missile-tracker/_dash-dependencies.json|g' {} \;
	find pages_files -exec sed -i.bak 's|missile-tracker/missile-tracker/_reload-hash|missile-tracker/missile-tracker/_reload-hash|g' {} \;
	find pages_files -exec sed -i.bak 's|missile-tracker/_dash-update-component|missile-tracker/missile-tracker/_dash-update-component|g' {} \;
	find pages_files -exec sed -i.bak 's|missile-tracker/assets|missile-tracker/missile-tracker/assets|g' {} \;

	mv pages_files/missile-tracker/_dash-layout pages_files/missile-tracker/_dash-layout.json
	mv pages_files/missile-tracker/_dash-dependencies pages_files/missile-tracker/_dash-dependencies.json
	mv missile-tracker/assets/* pages_files/missile-tracker/assets/

	ps -C python -o pid= | xargs kill -9

clean_dirs:
	ls
	rm -rf 127.0.0.1:8050/
	rm -rf pages_files/
	rm -rf joblib