import re
# match_intro = re.compile(r'(绪论)(\d+)$')
match_secion = re.compile(r'(第[\d\w]+章)(.*?)[\.⋯]*(\d+)$')
#match_secion = re.compile(r'(\d+)(.*?)[\.⋯]*(\d+)$')
# match_subsection = re.compile(r'([\d.]+\d)(.*?)[.⋯]*(\d+)$')
# match_subsection = re.compile(r'(\d{1,2}\.\d{1,2}(\.\d)?)(.*?)[\.⋯]*(\d+)$')
match_subsection = re.compile(r'(\d{1,2}(\.\d{1,2})?(\.\d)?)(.*?)[\.⋯]*(\d+)$')

# match_attachments = re.compile(r'(附录\w)(.*?)[\.⋯]*(\d+)$')

with open('catalog.txt', 'r', encoding='utf-8') as f:
    for line in f.readlines():
        '''
        intro_result = match_intro.match(line)
        if intro_result is not None:
            print(' '.join(intro_result.groups()))
            continue
        '''

        section_result = match_secion.match(line)
        if section_result is not None:
            print(' '.join(section_result.groups()))
            continue

        subsection_result = match_subsection.match(line)
        if subsection_result is not None:
            print(' '.join([
                subsection_result.group(1),
                subsection_result.group(4),
                subsection_result.group(5)
            ]))

            continue

        '''
        attachments_result = match_attachments.match(line)
        if attachments_result is not None:
            print(
                ' '.join(attachments_result.groups()))
            continue
        '''

        raise Exception(line)
