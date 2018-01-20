from utils import sanitize


class Bonus:

    def __init__(self, number, leadin="", texts=None, answers=None,
                 category="", subcategory="",
                 tournament="", round=""):
        self.number = number
        self.leadin = leadin
        self.texts = texts
        self.answers = answers
        self.category = category
        self.subcategory = subcategory
        self.tournament = tournament
        self.round = round

        if texts is None:
            self.texts = []
        if answers is None:
            self.answers = []

    def has_content(self):
        if len(self.texts) == 0 and len(self.answers) == 0:
            return False

        if len(self.texts) == 0 or len(self.answers) == 0:
            print "Discrepancy in Bonus %d" % self.number
            return False

        return self.texts[0].strip() != "" or self.answers[0].strip() != ""

    def to_dict(self):
        return {
            "number": self.number,
            "leadin": self.leadin,
            "formatted_texts": self.texts,
            "formatted_answers": self.answers,
            "texts": map(lambda x: sanitize(x, valid_tags=[]), self.texts),
            "answers": map(lambda x: sanitize(x, valid_tags=[]), self.answers),
            "category": self.category,
            "subcategory": self.subcategory,
            "tournament": self.tournament,
            "round": self.round
        }

    def __str__(self):
        return str(self.to_dict())

    def is_valid(self):
        return (self.leadin.strip() != "" and
                len(self.texts) == 3 and
                len(self.answers) == 3 and
                all(text.strip() != "" for text in self.texts) and
                all(answer.strip() != "" for answer in self.answers))

    def content(self):
        text = self.leadin
        for i in xrange(3):
            if len(self.texts) > i:
                text += " " + self.texts[i] + " ANSWER: " + self.answers[i]
        return text
