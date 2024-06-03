redeploy-lambda:
	rm -rf package
	mkdir package
	cp -R $$(poetry env info -p)/lib/python3.9/site-packages/* package/
	cp -R ./src/ ./package	
	cd ./tf/; . ./set-env.sh; terraform apply -auto-approve