run_app:
	python3 app.py & sleep 30

	mv 127.0.0.1:8050 pages_files
	ls -a pages_files

	find pages_files -type f -exec sed -i.bak 's|_dash-component-suites|missile-tracker/_dash-component-suites|g' {} \;
	find pages_files -type f -exec sed -i.bak 's|_dash-layout|missile-tracker/_dash-layout.json|g' {} \;
	find pages_files -type f -exec sed -i.bak 's|_dash-dependencies|missile-tracker/_dash-dependencies.json|g' {} \;
	find pages_files -type f -exec sed -i.bak 's|_reload-hash|missile-tracker/_reload-hash|g' {} \;
	find pages_files -type f -exec sed -i.bak 's|assets|missile-tracker/assets|g' {} \;

	mv pages_files/_dash-layout pages_files/_dash-layout.json
	mv pages_files/_dash-dependencies pages_files/_dash-dependencies.json

	ps -C python -o pid= | xargs -r kill -9

clean_dirs:
	ls
	rm -rf 127.0.0.1:8050/
	rm -rf pages_files/
	rm -rf joblib