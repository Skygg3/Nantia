#pragma once

#include <QObject>
#include <QUrl>

class TextHandler : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString fileName READ fileName NOTIFY fileUrlChanged)

public:
    TextHandler();

    QString fileName() const;

signals:
    void loaded(const QString &text);
    void fileUrlChanged();

public slots:
    void load(const QUrl &fileUrl);

private:
    QUrl m_fileUrl;
};

