class Main:
    def __init__(self, hoge: str):
        self.hoge = hoge

    def echo(self):
        print(self.hoge)


def main():
    my = Main("unti")
    my.echo()
