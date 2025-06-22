docker build -t blog-treino-app:latest .

docker run -d -p 80:80 blog-treino-app:latest

# Create a resource group
az group create --name blog-treino-rg --location eastus

# Create Container Registry
az acr create --resource-group blog-treino-rg --name blogtreinoregistry

# Log in to the Container Registry
az acr login --name blogtreinoregistry

# Tag the image
docker tag blog-treino-app:latest blogtreinoregistry.azurecr.io/blog-t

# Push the image to the Container Registry
docker push blogtreinoregistry.azurecr.io/blog-treino-app:latest

#containerID =blogtreinoacr.azurecr.io/blog-treino-app:latest
#user = blogtreinoacr
#password = 12345678reino

# Create environment for the container
az containerapp create --name blog-treino-app \
  --resource-group blog-treino-rg \
  --environment blog-treino-env \
  --image blogtreinoregistry.azurecr.io/blog-treino-app:latest \
  --target-port 80 \
  --ingress external \
  --registry-login-server blogtreinoregistry.azurecr.io \
  --registry-username blogtreinoregistry \
  --registry-password 12345678

  # Create a container app environment
az containerapp env create --name blog-treino-env \
  --resource-group blog-treino-rg \
  --location eastus \
  --logs-workspace-id /subscriptions/your-subscription-id/resourcegroups/blog-treino-rg/providers/microsoft.operationalinsights/workspaces/your-workspace-name \
  --logs-workspace-key your-workspace-key