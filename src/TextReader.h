#pragma once

#include <QObject>

class TextReader : public QObject
{
    Q_OBJECT

public:
    explicit TextReader(const QString &name);

public slots:
    void process();
    QString getFileContent() const { return fileContent; }

signals:
    void progress(int progress, const QString &line);
    void finished();

private:
    QString name;
    QString fileContent;
};
