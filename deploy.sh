VERSION=v1
IMAGE_NAME=parallaxxbot-$VERSION
SERVICE_NAME=parallaxxbot-$VERSION
PROJECT_NAME=brave-tech
PROJECT_ID=brave-tech
# SERVICE_ACCOUNT=parallaxxbot-sa@brave-tech.iam.gserviceaccount.com
REGION=europe-west1
KEY_FILE=.brave-tech-fbf08975ae32.json

docker build --tag $IMAGE_NAME .

# docker tag $IMAGE_NAME gcr.io/$PROJECT_NAME/$IMAGE_NAME:$VERSION
# docker push gcr.io/$PROJECT_NAME/$IMAGE_NAME:$VERSION

# gcloud run deploy --image gcr.io/$PROJECT_NAME/$IMAGE_NAME:$VERSION --service-account=$SERVICE_ACCOUNT --platform managed --region $REGION --allow-unauthenticated --port 8080 $IMAGE_NAME

gcloud builds submit \
  --project ${PROJECT_ID} \
  --tag gcr.io/${PROJECT_ID}/${SERVICE_NAME} && \
gcloud run deploy ${SERVICE_NAME} \
  --project ${PROJECT_ID} \
  --image gcr.io/${PROJECT_ID}/${SERVICE_NAME} \
  --platform managed \
  --region europe-west1 \
  --allow-unauthenticated \
  --set-env-vars "PROJECT_ID=${PROJECT_ID}"

curl -F "url=https://parallaxxbot-v1-ltkqeg557a-ew.a.run.app" https://api.telegram.org/$TELEGRAM_BOT_TOKEN/setWebhook
echo curl -F "url=https://parallaxxbot-v1-ltkqeg557a-ew.a.run.app" https://api.telegram.org/$TELEGRAM_BOT_TOKEN/setWebhook

gcloud run services describe $SERVICE_NAME --platform managed --region $REGION 
