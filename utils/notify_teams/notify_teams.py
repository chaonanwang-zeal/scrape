import os
import requests
import sys

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..', '..')))
from src.gcp.composer.mention_members import MENTION_MEMBERS
# from mention_members import MENTION_MEMBERS


def _prep_job_message(info, repository, commit_message, author, timestamp):
    """
    JOBが失敗した場合の通知メッセージを作成する
    失敗した場合は運用メンバーへメンションする

    Returns:
        dict: 通知メッセージ
    """

    entries = []
    mentions_text = 'デプロイ成功しました！\n\n'
    if info == 'failure':
        for m in MENTION_MEMBERS:
            entries.append(
                {
                    'type': 'mention',
                    'text': f'<at>{m}</at>',
                    'mentioned': {
                        'id': m,
                        'name': m.split('@')[0]
                    },
                }
            )
        mentions = ''.join([f'<at>{m}</at> ' for m in MENTION_MEMBERS])
        mentions_text = f'{mentions}\n\nデプロイ失敗しました！\n\n'

    text = f'{mentions_text}リポジトリ：{repository}\n\nコミットメッセージ：{commit_message}\n\n作成者：{author}\n\nタイムスタンプ：{timestamp}'

    message = {
        'type': 'message',
        'attachments': [{
            'contentType': 'application/vnd.microsoft.card.adaptive',
            'content': {
                'type': 'AdaptiveCard',
                'body': [{
                    'type': 'TextBlock',
                    'text': text,
                    'wrap': True
                }],
                '$schema': 'http://adaptivecards.io/schemas/adaptive-card.json',
                'version': '1.0',
                'msteams': {
                    'entities': entries,
                    'width': 'Full',
                },
            },
        }],
    }

    return message


def notify_message(webhook_url, info, repository, commit_message, author, timestamp):
    """
    メッセージをteamsへ通知する

    Args:
        message (string): 通知するメッセージ
        webhook_url (string): teamsへの通知に利用するwebhookのURL
    """
    response = requests.post(
        webhook_url,
        json=_prep_job_message(info, repository, commit_message, author, timestamp),
    )
    print(f'response: {response}')


if __name__ == "__main__":

    # パラメータ解析
    webhook_url = sys.argv[1]
    info = sys.argv[2]
    repository = sys.argv[3]
    commit_message = sys.argv[4]
    author = sys.argv[5]
    timestamp = sys.argv[6]

    # 関数実行
    notify_message(webhook_url, info, repository, commit_message, author, timestamp)
