#include "cachingnetworkaccessmanager.h"

#include "cachereply.h"

#include <QNetworkCacheMetaData>

CachingNetworkAccessManager::CachingNetworkAccessManager(QObject *parent) : QNetworkAccessManager(parent) {
  mUrlIgnoreList.append("https://felgo.com/qml-sources/qtws2019/QtWSVersionCheck-test.qml");
  mUrlIgnoreList.append("https://felgo.com/qml-sources/qtws2019/QtWSVersionCheck.qml");
  mUrlIgnoreList.append("https://felgo.com/qml-sources/qmldir");
}

QNetworkReply *CachingNetworkAccessManager::createRequest(QNetworkAccessManager::Operation op, const QNetworkRequest &req, QIODevice *outgoingData)
{
  QNetworkCacheMetaData meta = cache()->metaData(req.url());
  if(meta.isValid() && !shouldIgnoreUrl(req.url().url())) {
    //cache contains URL -> return cache reply
    //TODO need to check for expiration date?
    return new CacheReply(cache()->data(req.url()), req, op, meta, this);
  } else {
    return QNetworkAccessManager::createRequest(op, req, outgoingData);
  }
}

bool CachingNetworkAccessManager::shouldIgnoreUrl(const QString &url)
{
  return mUrlIgnoreList.contains(url);
}

void CachingNetworkAccessManager::clearIgnoredUrlsFromCache() {
  for(int i=0; i < mUrlIgnoreList.count(); i++) {
    QString url = mUrlIgnoreList.at(i);
    cache()->remove(url);
  }
}
