#pragma once

#include <vector>

#include <QObject>
#include <QUrl>

class TextReader;

class TextHandler : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString fileName READ fileName NOTIFY fileUrlChanged)
    Q_PROPERTY(bool hasFile READ hasFile NOTIFY hasFileChanged)

public:
    Q_INVOKABLE QString getLine(int lineNumber);
    Q_INVOKABLE int numberOfLine();

public:
    TextHandler();

    QString fileName() const;
    bool hasFile() const { return !m_fileUrl.isEmpty(); }

signals:
    void threadStarted();
    void threadProgress(double progress);
    void threadFinished();
    void loaded(const QString &text);
    void fileUrlChanged();
    void hasFileChanged();

public slots:
    void load(const QUrl &fileUrl);

    void newLine(const QByteArray &newLine);
    void threadProgressHandler(int progress);
    void threadFinishedHandler();

private:
    QUrl m_fileUrl;
    TextReader *reader;

    std::vector<QByteArray> m_textData;
};

