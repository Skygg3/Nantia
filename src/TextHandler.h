#pragma once

#include <QObject>
#include <QUrl>

class TextReader;

class TextHandler : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString fileName READ fileName NOTIFY fileUrlChanged)

public:
    TextHandler();

    QString fileName() const;

signals:
    void threadStarted();
    void threadProgress(double progress, const QString &line);
    void threadFinished();
    void loaded(const QString &text);
    void fileUrlChanged();

public slots:
    void load(const QUrl &fileUrl);

    void threadProgressHandler(int progress, const QString &line);
    void threadFinishedHandler();

private:
    QUrl m_fileUrl;
    TextReader *reader;
};

