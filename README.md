# notivocab(通知で覚える英単語アプリ)

## 概要
英単語をランダムで決められた時刻にpush通知を出すことで、ユーザに英単語を強制的に学習させるアプリ




## 画面一覧

### Figmaでの遷移検討
<img src="https://github.com/user-attachments/assets/a411d609-e236-4dc4-8208-5651a8f3af91" width="1000">


### ホーム画面
<img src="https://github.com/user-attachments/assets/ae7c8e84-f2c5-4ba5-9c80-cf05ecc9cd90" width="300">

### コース別英単語帳(NGSLv2.1の単語リスト)
- 単語は初級・中級・上級の3つのランクに分かれており、更にその中でセクションで分かれている。
- セクションのカードを押下すると単語一覧画面に遷移する。
<img src="https://github.com/user-attachments/assets/8aa9348c-6dde-4c7d-83d1-354910ffc32a" width="300">
<img src="https://github.com/user-attachments/assets/4cb71707-8fc8-4194-b693-428dd4f3c1fc" width="300">

### 単語一覧画面
- NGSLv2.1に記載された単語一覧を表示する。
- 各単語のカードを押下すると単語詳細画面に遷移する。
<img src="https://github.com/user-attachments/assets/84ffeeb0-34d3-43b5-bbcc-718a7c6b95ab" width="300">

### 単語詳細画面
<img src="https://github.com/user-attachments/assets/c6e87097-92b1-412f-89c9-306ed1404281" width="300">


### 通知設定画面
- 通知画面で設定した時刻にローカルpush通知を配信する。
- ここでは通知を出す時刻と、通知で出される英単語の範囲を選択する設定を行う。
<img src="https://github.com/user-attachments/assets/6180ec3d-f845-4625-ad38-efe7a2e059d9" width="300">
<img src="https://github.com/user-attachments/assets/2ecc11a1-59ca-47e3-949d-dc3d69dca280" width="300">
<img src="https://github.com/user-attachments/assets/10bdb100-8c46-4ee2-b519-42bef5d07b12" width="300">


