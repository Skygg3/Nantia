#pragma once

#include <QObject>

class TextReader : public QObject
{
    Q_OBJECT

public:
    explicit TextReader(const QString &name);

public slots:
    void process();

signals:
    void progress(uint progress);
    void newLine(const QByteArray &line);
    void finished();

private:
    QString name;
};
