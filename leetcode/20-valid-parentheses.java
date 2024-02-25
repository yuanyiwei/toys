class Solution {
    public boolean isValid(String s) {
        int length = s.length() / 2;
        for (int i = 0; i < length; i++) {
            s = s.replace("()", "").replace("{}", "").replace("[]", "");
        }

        return s.length() == 0;
    }

    // private static final Map<Character,Character> map = new HashMap<Character,Character>(){{
    //     put('{','}'); put('[',']'); put('(',')'); put('?','?');
    // }};
    // public boolean isValid(String s) {
    //     if(s.length() > 0 && !map.containsKey(s.charAt(0))) return false;
    //     LinkedList<Character> stack = new LinkedList<Character>() {{ add('?'); }};
    //     for(Character c : s.toCharArray()){
    //         if(map.containsKey(c)) stack.addLast(c);
    //         else if(map.get(stack.removeLast()) != c) return false;
    //     }
    //     return stack.size() == 1;
    // }
}
